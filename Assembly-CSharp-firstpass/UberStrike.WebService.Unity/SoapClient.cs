using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using UnityEngine;
using UnityEngine.Networking;

namespace UberStrike.WebService.Unity
{
	internal static class SoapClient
	{
		private static int _requestId;

		private static void LogRequest(int id, float time, int sizeBytes, string interfaceName, string serviceName, string methodName)
		{
			if (Configuration.RequestLogger != null)
			{
				string text = ((float)sizeBytes / 1000f).ToString();
				Configuration.RequestLogger(string.Format("[REQ] ID:{0} Time:{1:N2} Size:{2:N2}Kb Service:{3} Interface:{4} Method:{5}", id, time, text, serviceName, interfaceName, methodName));
			}
		}

		private static void LogResponse(int id, float time, string message, float duration, int sizeBytes)
		{
			if (Configuration.RequestLogger != null)
			{
				string text = ((float)sizeBytes / 1000f).ToString();
				Configuration.RequestLogger(string.Format("[RSP] ID:{0} Time:{1:N2} Size:{2:N2}Kb Duration:{3:N2}s Status:{4}", id, time, text, duration, message));
			}
		}

		public static IEnumerator MakeRequest(string interfaceName, string serviceName, string methodName, byte[] data, Action<byte[]> requestCallback, Action<Exception> exceptionHandler)
		{
			// SOAP envelope adapter for the community Kestrel server.
			// Verified live (2026-04-15): the community server speaks the original
			// Cmune SOAP protocol unchanged — same envelope, same SOAPAction, same
			// base64-encoded <data> element, same <MethodNameResult> response wrap.
			// The ONLY difference from the original Cmune backend is the URL path:
			//   ORIGINAL: {base}/UberStrike.DataCenter.WebService.CWS.{Svc}Contract.svc
			//   COMMUNITY: {base}/{ShortServiceName}
			// where ShortServiceName drops the namespace prefix, "Contract" suffix
			// and ".svc" extension. We derive it from interfaceName by stripping
			// the leading "I" and trailing "Contract":
			//   "IApplicationWebServiceContract" -> "ApplicationWebService"
			// Method name still goes inside the SOAP envelope, NOT the URL path.
			int requestId = _requestId++;
			string shortService = interfaceName;
			if (shortService.StartsWith("I"))
			{
				shortService = shortService.Substring(1);
			}
			if (shortService.EndsWith("Contract"))
			{
				shortService = shortService.Substring(0, shortService.Length - "Contract".Length);
			}
			string url = Configuration.WebserviceBaseUrl + shortService;

			string envelope = "<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"><s:Body><" + methodName + " xmlns=\"http://tempuri.org/\"><data>" + Convert.ToBase64String(data) + "</data></" + methodName + "></s:Body></s:Envelope>";
			byte[] envelopeBytes = Encoding.UTF8.GetBytes(envelope);

			XmlDocument doc = new XmlDocument();
			float startTime = Time.realtimeSinceStartup;
			LogRequest(requestId, startTime, data.Length, interfaceName, serviceName, methodName);
			yield return new WaitForEndOfFrame();
			if (WebServiceStatistics.IsEnabled)
			{
				WebServiceStatistics.RecordWebServiceBegin(methodName, envelopeBytes.Length);
			}
			byte[] returnData = null;
			using (UnityWebRequest request = new UnityWebRequest(url, UnityWebRequest.kHttpVerbPOST))
			{
				request.uploadHandler = new UploadHandlerRaw(envelopeBytes);
				request.downloadHandler = new DownloadHandlerBuffer();
				request.SetRequestHeader("Content-Type", "text/xml; charset=utf-8");
				request.SetRequestHeader("SOAPAction", "\"http://tempuri.org/" + interfaceName + "/" + methodName + "\"");
				yield return request.SendWebRequest();

				bool isSuccess = request.result == UnityWebRequest.Result.Success;
				string responseText = request.downloadHandler != null ? request.downloadHandler.text : string.Empty;
				int responseSize = request.downloadHandler != null && request.downloadHandler.data != null ? request.downloadHandler.data.Length : 0;

				if (WebServiceStatistics.IsEnabled)
				{
					WebServiceStatistics.RecordWebServiceEnd(methodName, responseSize, isSuccess);
				}
				try
				{
					if (Configuration.SimulateWebservicesFail)
					{
						throw new Exception("Simulated Webservice fail when calling " + interfaceName + "/" + methodName);
					}
					if (isSuccess)
					{
						if (!string.IsNullOrEmpty(responseText))
						{
							try
							{
								doc.LoadXml(responseText);
								XmlNodeList result = doc.GetElementsByTagName(methodName + "Result");
								if (result.Count <= 0)
								{
									LogResponse(requestId, Time.realtimeSinceStartup, responseText, Time.time - startTime, 0);
									throw new Exception("Request to " + url + " failed with content " + responseText);
								}
								returnData = Convert.FromBase64String(result[0].InnerXml);
								if (returnData.Length == 0)
								{
									LogResponse(requestId, Time.realtimeSinceStartup, responseText, Time.time - startTime, 0);
									throw new Exception("Request to " + url + " returned empty data");
								}
								LogResponse(requestId, Time.realtimeSinceStartup, "OK", Time.realtimeSinceStartup - startTime, responseSize);
							}
							catch (Exception innerEx) when (!(innerEx.Message.StartsWith("Request to ")))
							{
								LogResponse(requestId, Time.time, responseText, Time.realtimeSinceStartup - startTime, 0);
								throw new Exception("Error reading XML return for method call " + interfaceName + "/" + methodName + ": " + responseText);
							}
						}
						if (requestCallback != null)
						{
							requestCallback(returnData);
						}
					}
					else
					{
						LogResponse(requestId, Time.realtimeSinceStartup, request.error, Time.time - startTime, 0);
						throw new Exception(request.error + " (HTTP " + request.responseCode + ")\nUrl: " + url + "\nService: " + interfaceName + "\nMethod: " + methodName);
					}
				}
				catch (Exception ex)
				{
					if (exceptionHandler != null)
					{
						exceptionHandler(ex);
					}
					else
					{
						Debug.LogError("SoapClient Unhandled Exception: " + ex.Message + "\n" + ex.StackTrace);
					}
				}
			}
		}
	}
}

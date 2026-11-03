using System;

namespace Cmune.DataCenter.Common.Entities
{
	[Serializable]
	public class CheckApplicationVersionView
	{
		public ApplicationView ClientVersion { get; set; }

		public ApplicationView CurrentVersion { get; set; }

		public CheckApplicationVersionView()
		{
		}

		public CheckApplicationVersionView(ApplicationView clienVersion, ApplicationView currentVersion)
		{
			ClientVersion = clienVersion;
			CurrentVersion = currentVersion;
		}

		public override string ToString()
		{
			string[] obj = new string[5] { "[CheckApplicationVersionView: [ClientVersion: ", null, null, null, null };
			ApplicationView clientVersion = ClientVersion;
			obj[1] = ((clientVersion != null) ? clientVersion.ToString() : null);
			obj[2] = "][CurrentVersion: ";
			ApplicationView currentVersion = CurrentVersion;
			obj[3] = ((currentVersion != null) ? currentVersion.ToString() : null);
			obj[4] = "]]";
			return string.Concat(obj);
		}
	}
}

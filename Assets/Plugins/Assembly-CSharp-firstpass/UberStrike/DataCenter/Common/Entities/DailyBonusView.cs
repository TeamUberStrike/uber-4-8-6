using System;

namespace UberStrike.DataCenter.Common.Entities
{
	[Serializable]
	public class DailyBonusView
	{
		public int Streak { get; set; }

		public int RewardClass { get; set; }

		public string Label { get; set; }

		public int Amount { get; set; }

		public int Duration { get; set; }
	}
}

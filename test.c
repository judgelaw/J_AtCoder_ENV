#include <stdio.h>

// AWC0001-E問題
// https://atcoder.jp/contests/awc0001/tasks/awc0001_e

// geminiさんにpythonコードから変換してもらい作成

#define MAX_N 200005

long long h[MAX_N];
// デキューを2つ用意する（最大値用と最小値用）
int q_min[MAX_N], q_max[MAX_N];

int main()
{
	int n, k;
	if (scanf("%d %d", &n, &k) != 2)
		return 0;

	for (int i = 0; i < n; i++)
	{
		scanf("%lld", &h[i]);
	}

	int h_min = 0, t_min = 0; // 最小値デキューのhead, tail
	int h_max = 0, t_max = 0; // 最大値デキューのhead, tail
	long long max_diff = 0;

	for (int i = 0; i < n; i++)
	{
		// --- 最小値の更新 ---
		if (h_min < t_min && q_min[h_min] <= i - k)
			h_min++;
		while (h_min < t_min && h[q_min[t_min - 1]] > h[i])
			t_min--;
		q_min[t_min++] = i;

		// --- 最大値の更新 ---
		if (h_max < t_max && q_max[h_max] <= i - k)
			h_max++;
		while (h_max < t_max && h[q_max[t_max - 1]] < h[i])
			t_max--;
		q_max[t_max++] = i;

		// --- その場で差を計算 ---
		// 配列 th, tl に保存せず、直接引き算して最大値を更新する
		long long current_max = h[q_max[h_max]];
		long long current_min = h[q_min[h_min]];
		long long diff = current_max - current_min;

		if (diff > max_diff)
		{
			max_diff = diff;
		}
	}

	printf("%lld\n", max_diff);

	return 0;
}
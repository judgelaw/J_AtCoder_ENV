#include <bits/stdc++.h>
using namespace std;
#define rep(i, n) for (int i = 0; i < int(n); i++)
#define repst(i, s, t) for (int i = int(s); i < int(t); i++)
#include <atcoder/all>
using namespace atcoder;
using i64 = long long;
constexpr int INF = 1234567890;

// AWC0001-E問題
// https://atcoder.jp/contests/awc0001/tasks/awc0001_e

i64 op_min(i64 a, i64 b) { return min(a, b); }
i64 op_max(i64 a, i64 b) { return max(a, b); }

int e_min() { return -INF; }
int e_max() { return INF; }

int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int N, K, H;
    cin >> N >> K;

    vector<int> A;

    segtree<i64, op_min, e_max> T_min(N);
    segtree<i64, op_max, e_min> T_max(N);

    rep(i, N)
    {
        cin >> H;
        T_min.set(i, H);
        T_max.set(i, H);
    }

    i64 res = 0;
    rep(i, N - K + 1)
    {
        i64 t_h, t_l;

        t_h = T_max.prod(i, i + K);
        t_l = T_min.prod(i, i + K);
        res = max(res, t_h - t_l);
    }

    cout << res << "\n";
}
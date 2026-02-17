import sys
input = lambda: sys.stdin.readline().rstrip()

from collections import deque

# AWC0001-E問題
# https://atcoder.jp/contests/awc0001/tasks/awc0001_e


# 配列Aの連続K個中の最小値を求める
def Slide_Minimum(A,K):
    ret=[]
    q=deque()

    N=len(A)
    for i in range(N):
        a=A[i]
        while q and q[0]<=i-K:q.popleft()
        while q and A[q[-1]]>a:q.pop()
        q.append(i)
        ret.append(A[q[0]])

    return ret

# 配列Aの連続K個中の最大を求める
def Slide_Maximum(A,K):
    ret=[]
    q=deque()

    N=len(A)
    for i in range(N):
        a=A[i]
        while q and q[0]<=i-K:q.popleft()
        while q and A[q[-1]]<a:q.pop()
        q.append(i)
        ret.append(A[q[0]])

    return ret

N,K=map(int,input().split())
H=list(map(int, input().split()))


TH=Slide_Maximum(H,K)
TL=Slide_Minimum(H,K)

res=0
for i in range(N):res=max(res,TH[i]-TL[i])
print(res)
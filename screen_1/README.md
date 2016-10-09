# etude
It's a project of Aluan.
The module here is based on Processing.

2016/10/8
目前已經就上次討論大部分完成了，剩下 box2D 的設計還沒進行。
除此之外，我覺得還有許多需要改進的部分：

1.圖層
進行 monitor 選取的動作的時候應該要有分層的概念
也就是說，應該要可以在點選特定 monitor 的時候就將其上排到第一個去
這個問題只需要在 main 裡面的 monitors 處理排列問題就可以解決
但這個部分應該會有個問題，就是關於 id 的設定
因為目前是就其生成的時候的 monitor number 去生成
之後要改成流水號就不會有 id 重複的問題了

2.pose detection
姿勢感應的部分應該還有許多 bug 需要處理
現在只有一個標準的 input 是完全正確的辨識
其他雖然沒有檢查 但是應該有滿多問題的

感應的反饋機制也還沒完全做完
到特定區域的動作應該要顯示出動態
像是手舉起來的時候應該要有個顯示目前角度的方法
還有抓手的時候有圓形與圓形內部的閃光

3.data error filter
因為常常有 kinect 傳進來的訊息爛掉的
所以要設計一下把這些資料擋住
不要讓人一下子就在某些 frame 被分屍

4.Theremin Display
目前 theremin mode 在螢幕上面除了點擊之外的地方是沒有回饋的
希望可以加上像是 puredata 範例 code 中的那種彈性線的效果
我的實作應該是用固定數量的點 去畫出 底部 x 跟隨手部漸進運動去製造那樣的效果



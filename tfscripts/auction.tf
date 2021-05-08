;;; ----------------------------------------------------------------------------
;;; auction.tf
;;; Auction helpers and tracking.
;;; ----------------------------------------------------------------------------
; The auctioneer auctions '\=\=\= Item #155 (a perfect diamond) sold to Bammo for 8000000 gold. \=\=\='
/def -mregexp -p500 -F -t"^The auctioneer auctions '\=\=\= Item \#([0-9]+) \(.+\) sold to ([a-zA-Z]+) for ([0-9]+) gold\. \=\=\='" auction_item_sold = \
    /let itemNumber=$[strip_attr({P1})]%;\
    /let itemDesc=$[strip_attr({P2})]%;\
    /let itemWinner=$[strip_attr({P3})]%;\
    /let itemCost=$[strip_attr({P4})]%;\
    /echo -pw %{itemWinner} won %{itemNumber} - %{itemDesc} --> %{itemCost}

;The auctioneer auctions '\=\=\= Flu has posted a pair of cut-off trousers on auction. Level 51. Minimum bid 50000.  Item# 268. \=\=\='
/def -mregexp -p500 -F -t"^The auctioneer auctions '\=\=\= ([a-zA-Z]+) has posted (.+) on auction\. Level ([0-9]+)\. Minimum bid ([0-9]+)\.  Item# (\d+)\. \=\=\='" auction_item_post = \
    /let itemPoster=$[strip_attr({P1})]%;\
    /let itemDesc=$[strip_attr({P2})]%;\
    /let itemLevel=$[strip_attr({P3})]%;\
    /let itemMinBid=$[strip_attr({P4})]%;\
    /let itemNumber=$[strip_attr({P5})]%;\
    /echo -pw %{itemPoster} posted %{itemNumber} - %{itemLevel} %{itemDesc} --> %{itemMinBid}

;The auctioneer auctions '\=\=\= Item #250 (a stout branch) found no buyer.Theauction has ended. \=\=\='
/def -mregexp -p500 -F -t"^The auctioneer auctions '\=\=\= Item #([0-9]+) \((.+)\) found no buyer\.The auction has ended\. \=\=\='" auction_item_no_buyer = \
    /let itemNumber=$[strip_attr({P1})]%;\
    /let itemDesc=$[strip_attr({P2})]%;\
    /echo -pw %{itemNumber} - %{itemDesc} found no buyer

; The auctioneer auctions '=== New Bid: Item #653 (corrupted staff of Typhus). Level 51. Current bid 200. ==='
/def -mregexp -p500 -F -t"^The auctioneer auctions '\=\=\= New Bid\: Item \#([0-9]+) \((.+)\)\. Level ([0-9]+)\. Current bid ([0-9]+)\. \=\=\='" auction_item_new_bid = \
    /let itemNumber=$[strip_attr({P1})]%;\
    /let itemDesc=$[strip_attr({P2})]%;\
    /let itemLevel=$[strip_attr({P3})]%;\
    /let currentBid=$[strip_attr({P4})]%;\
    /echo -pw %{itemNumber} - (%{itemLevel}) %{itemDesc} new bid: %{currentBid}

;; auction house testing
; ### |  Curr Bid  | Time | Level | min bid
;---------------------------------------------------------------------
;  36 |     1,200,000 |  451 |    55 | 1,000,000
;  46 |             0 | 1220 |    56 | 4,000,000
; 104 |             0 | 3094 |    53 |    20,000
; 146 |       369,000 | 4089 |     1 |       100

;/def -mregexp -ag -p0 -t"^ +([0-9]+) \| +([\,0-9]+) \| +([0-9]+) \| +([0-9]+) \| +([\,0-9]+)$" auction_house_list = \
;    /let itemNumber=%{P1}%;\
;    /let currentBid=%{P2}%;\
;    /let bidTime=%{P3}%;\
;    /let bidLevel=%{P4}%;\
;    /let minBid=%{P5}%;\
;    /echo -pw Item#: %{itemNumber} | Curr Bid: %{currentBid} | Time: %{bidTime} | Level: %{bidLevel} | Min Bid: %{minBid}
    
;/def -mregexp -au -p0 -t"^     > .+" auction_house_item


;;; auction-bot triggers
;Your bid of 160 on Item 675 corrupted staff of Typhus is no longer the 
;highest bid. The current highest bid is 170.

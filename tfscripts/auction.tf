;;; ----------------------------------------------------------------------------
;;; auction.tf
;;; Auction helpers and tracking.
;;; ----------------------------------------------------------------------------
;The auctioneer auctions '=== Fybkes has cancelled auction of a stone plated skirt.  Item #49. ===' 
/def -mregexp -p500 -F -t"^The auctioneer auctions '\=\=\= ([a-zA-Z]+) has cancelled auction of (.+)\.  Item# (\d+)\. \=\=\='" auction_item_cancel = \
    /let _itemPoster=$[strip_attr({P1})]%;\
    /let _itemDesc=$[strip_attr({P2})]%;\
    /let _itemMinBid=$[strip_attr({P3})]%;\
    /echo -pw @{Cred}[AUCTION INFO:] Delete item %{_itemNumber}|%{_itemDesc}%;\
    /if ({log_auction}) \
        /sendlocal auctiondel:%{_itemNumber}|%{_itemDesc}%;\
    /endif

/def -mregexp -p500 -F -t"^The auctioneer auctions '\=\=\= Item \#([0-9]+) +\((.+)\) sold to ([a-zA-Z]+) for ([0-9\,]+) gold\. \=\=\='" auction_item_sold = \
    /let _itemNumber=$[strip_attr({P1})]%;\
    /let _itemDesc=$[strip_attr({P2})]%;\
    /let _itemWinner=$[strip_attr({P3})]%;\
    /let _itemCost=$[strip_attr({P4})]%;\
;    /echo -pw @{Cred}[AUCTION INFO:] Delete item %{_itemNumber}|%{_itemDesc}%;\
    /if ({log_auction}) \
        /sendlocal auctiondel:%{_itemNumber}|%{_itemDesc}%;\
    /endif

/def -mregexp -p500 -F -t"^The auctioneer auctions '\=\=\= ([a-zA-Z]+) has posted (.+) on auction\. Level ([0-9]+)\. Minimum bid ([0-9\,]+)\.  Item# (\d+)\. \=\=\='" auction_item_post = \
    /let _itemPoster=$[strip_attr({P1})]%;\
    /let _itemDesc=$[strip_attr({P2})]%;\
    /let _itemLevel=$[strip_attr({P3})]%;\
    /let _itemMinBid=$[strip_attr({P4})]%;\
    /let _itemNumber=$[strip_attr({P5})]%;\
;    /echo -pw %{_itemPoster} posted %{_itemNumber} - %{_itemLevel} %{_itemDesc} --> %{_itemMinBid}%;\
    /if ({log_auction}) \
        /sendlocal auction:%{_itemNumber}|%{_itemDesc}|0|999|%{_itemLevel}|%{_itemMinBid}|%{_itemPoster}%;\
    /endif

/def -mregexp -p500 -F -t"^The auctioneer auctions '\=\=\= Item \#([0-9]+) \((.+)\) found no buyer\. The auction has ended\. \=\=\='" auction_item_no_buyer = \
    /let _itemNumber=$[strip_attr({P1})]%;\
    /let _itemDesc=$[strip_attr({P2})]%;\
;    /echo -pw @{Cred}[AUCTION INFO:] %{_itemNumber} - %{_itemDesc} found no buyer%;\
    /if ({log_auction}) \
        /sendlocal auctiondel:%{_itemNumber}|%{_itemDesc}%;\
    /endif

/def -mregexp -p500 -F -t"^The auctioneer auctions '\=\=\= New Bid\: Item \#([0-9]+) \((.+)\)\. Level ([0-9]+)\. Current bid ([0-9\,]+)\. \=\=\='" auction_item_new_bid = \
    /let _itemNumber=$[strip_attr({P1})]%;\
    /let _itemDesc=$[strip_attr({P2})]%;\
    /let _itemLevel=$[strip_attr({P3})]%;\
    /let _currentBid=$[strip_attr({P4})]%;\
;    /echo -pw %{_itemNumber} - (%{_itemLevel}) %{_itemDesc} new bid: %{_currentBid}%;\
    /if ({log_auction}) \
        /sendlocal auctionupd:%{_itemNumber}|%{_itemDesc}|%{_currentBid}%;\
    /endif

;;; auction-bot triggers
;Your bid of 160 on Item 675 corrupted staff of Typhus is no longer the 
;highest bid. The current highest bid is 170.

;Your bid of 1000000 on Item 150 see ctibor for armor base upgrade by 1 (non-manifest only) is no longer the
;highest bid. The current highest bid is 2000000.

;The auction of a necklace of severed Fae ears (treasure) has ended and your bid of 25000 was successful. You have received the item.

/def -ag -p999 -mregexp -t"^ \#\#\# \|  Current Bid  \| Time \| Level \|  Min Bid  " auction_gag_header
;/def -ag -p999 -mglob -t"---------------------------------------------------------------------" auction_gag_line

;; Auction highlighting
/def -ag -mregexp -p999 -t"^ +([0-9]+) \| +([0-9\,]+) \| +([0-9]+) \| +([0-9 ]+) \| +([0-9\,]+)(.*)" highlight_auction_list = \
    /set auctionItemNumber=%{P1}%;\
    /set currentBid=%{P2}%;\
    /set auctionMins=%{P3}%;\
    /set auctionHours=$[{P3}/60]%;\
    /set auctionLevel=%{P4}%;\
    /set minBid=%{P5}%;\
    /set auctionBidderAtt=x%;\
    /if ({P6} =/ " | *You are the highest bidder*") \
        /set auctionBidderAtt=u%;\
    /endif%;\
    /if ({auctionHours} > 1) /let auctionTime=%{auctionHours}h%;/else /let auctionTime=%{auctionMins}m%;/endif

/def -ag -mregexp -p999 -t"^     > (.*)" auction_list_item =\
    /let auctionItem=%{P1}%;\
    /echo -pw -a%{auctionBidderAtt} Item: %auctionItem (#%auctionItemNumber), Current Bid: %currentBid, Time: %auctionMins, Level: %auctionLevel, Min: %minBid%;\
    /if ({log_auction}) \
        /sendlocal auction:%{auctionItemNumber}|%{auctionItem}|%{currentBid}|%{auctionMins}|%{auctionLevel}|%{minBid}|NA%;\
    /endif

/def clrauction = \
    /echo -pw @{Cred}[AUCTION INFO:] Clearing Auction Data%;\
    /sendlocal auctionclr
/def logauction = \
    /toggle log_auction%;\
    /echoflag %{log_auction} Capturing Auction House

; Force it off, and turn it on
/set log_auction=0
/logauction


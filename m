Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7C14EE30
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 Jan 2020 15:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgAaOJO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 Jan 2020 09:09:14 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:33740 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgAaOJO (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:09:14 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1ixWyr-00074w-4U; Fri, 31 Jan 2020 15:09:09 +0100
Date:   Fri, 31 Jan 2020 15:09:09 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>
Cc:     Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Proxy load balancer rules
Message-ID: <20200131140909.GR28318@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>,
        Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
References: <DEB99F9B-0D1A-40DD-97C8-3FB0C4E24CD6@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEB99F9B-0D1A-40DD-97C8-3FB0C4E24CD6@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Serguei,

On Thu, Jan 30, 2020 at 05:12:07PM +0000, Serguei Bezverkhi (sbezverk) wrote:
[...]
> 
> !
> !   -m recent --rcheck --seconds 10800 --reap  --rsource - keywords I am looking for equivalent in  nftables  
> !
> 
> -A KUBE-XLB-BAJ42O6WMSSB7YGA -m comment --comment "services-9837/affinity-lb-esipp-transition:" -m recent --rcheck --seconds 10800 --reap --name KUBE-SEP-JAOQ4ZBNFGZ34AZ4 --mask 255.255.255.255 --rsource -j KUBE-SEP-JAOQ4ZBNFGZ34AZ4
> -A KUBE-XLB-BAJ42O6WMSSB7YGA -m comment --comment "services-9837/affinity-lb-esipp-transition:" -m recent --rcheck --seconds 10800 --reap --name KUBE-SEP-WLHDVQTL57VBPURE --mask 255.255.255.255 --rsource -j KUBE-SEP-WLHDVQTL57VBPURE
> -A KUBE-XLB-BAJ42O6WMSSB7YGA -m comment --comment "services-9837/affinity-lb-esipp-transition:" -m recent --rcheck --seconds 10800 --reap --name KUBE-SEP-5XWCIKNI3M4MWAMU --mask 255.255.255.255 --rsource -j KUBE-SEP-5XWCIKNI3M4MWAMU

There is no direct equivalent for recent extension in nftables (yet).
But in this case I think a set with timeout would do the trick.

The above simply checks if saddr is part of that set (--rcheck). The
value given in --seconds would be the set's default element timeout. No
need for --reap, elements will disappear automatically.

[...]
> -A KUBE-SEP-5XWCIKNI3M4MWAMU -s 57.112.0.208/32 -j KUBE-MARK-MASQ
> -A KUBE-SEP-5XWCIKNI3M4MWAMU -p tcp -m recent --set --name KUBE-SEP-5XWCIKNI3M4MWAMU --mask 255.255.255.255 --rsource -m tcp -j DNAT [unsupported revision]
> 
> -A KUBE-SEP-JAOQ4ZBNFGZ34AZ4 -s 57.112.0.206/32 -j KUBE-MARK-MASQ
> -A KUBE-SEP-JAOQ4ZBNFGZ34AZ4 -p tcp -m recent --set --name KUBE-SEP-JAOQ4ZBNFGZ34AZ4 --mask 255.255.255.255 --rsource -m tcp -j DNAT [unsupported revision]
> 
> -A KUBE-SEP-WLHDVQTL57VBPURE -s 57.112.0.207/32 -j KUBE-MARK-MASQ
> -A KUBE-SEP-WLHDVQTL57VBPURE -p tcp -m recent --set --name KUBE-SEP-WLHDVQTL57VBPURE --mask 255.255.255.255 --rsource -m tcp -j DNAT [unsupported revision]

These rules add saddr to the set or reset the timeout if already
present.

So, in order to replicate the above in nftables, you would:

* Add a new set for each different --name values given above
  - define a default timeout (suggested)
  - define a max size (suggested)
* Translate --rcheck into a simple set lookup
* Translate --set into set statement:
  'update @setxy { ip saddr timeout 10800 }'
  - use 'update' instead of 'add' to reset the timeout

For further info, please refer to nft manpage[1] as well as nftables
wiki[2].

Cheers, Phil

[1] 'SETS' and 'SET STATEMENT' sections in nft(8) 
[2] https://wiki.nftables.org/wiki-nftables/index.php/Updating_sets_from_the_packet_path


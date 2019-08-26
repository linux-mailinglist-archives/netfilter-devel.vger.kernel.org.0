Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4E9CC9B
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2019 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfHZJa5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Aug 2019 05:30:57 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:57483 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbfHZJa5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:30:57 -0400
Received: from [31.4.213.210] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pablo@gnumonks.org>)
        id 1i2BKs-00032V-9R; Mon, 26 Aug 2019 11:30:56 +0200
Date:   Mon, 26 Aug 2019 11:30:48 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCHv3] netfilter: nfnetlink_log:add support for VLAN
 information
Message-ID: <20190826093048.wqzsq4he3eljoafy@salvia>
References: <20190820131146.20787-1-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820131146.20787-1-michael-dev@fami-braun.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:11:46PM +0200, Michael Braun wrote:
> Currently, there is no vlan information (e.g. when used with a vlan aware
> bridge) passed to userspache, HWHEADER will contain an 08 00 (ip) suffix
> even for tagged ip packets.
> 
> Therefore, add an extra netlink attribute that passes the vlan information
> to userspace similarly to 15824ab29f for nfqueue.

Applied, with one minor glitch.

[...]
> diff --git a/net/netfilter/nf_log_common.c b/net/netfilter/nf_log_common.c
> index ae5628ddbe6d..c127bcc119d8 100644
> --- a/net/netfilter/nf_log_common.c
> +++ b/net/netfilter/nf_log_common.c
> @@ -167,6 +167,8 @@ nf_log_dump_packet_common(struct nf_log_buf *m, u_int8_t pf,
>  	physoutdev = nf_bridge_get_physoutdev(skb);
>  	if (physoutdev && out != physoutdev)
>  		nf_log_buf_add(m, "PHYSOUT=%s ", physoutdev->name);
> +	if (skb_vlan_tag_present(skb))
> +		nf_log_buf_add(m, "VLAN=%d ", skb_vlan_tag_get_id(skb));
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(nf_log_dump_packet_common);

I have kept this chunk behind. I think exposing the VPROTO would be
useful too. Just send a separated patch for this for review, thanks.

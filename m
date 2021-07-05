Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB73F3BB9A3
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Jul 2021 10:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhGEIz0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Jul 2021 04:55:26 -0400
Received: from mail.netfilter.org ([217.70.188.207]:47370 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGEIz0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:55:26 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id E6A826164E;
        Mon,  5 Jul 2021 10:52:38 +0200 (CEST)
Date:   Mon, 5 Jul 2021 10:52:46 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] src: annotation: Correctly identify
 item for which header is needed
Message-ID: <20210705085246.GA16975@salvia>
References: <20210704054708.8495-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210704054708.8495-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jul 04, 2021 at 03:47:08PM +1000, Duncan Roe wrote:
> Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
> ---
>  examples/nf-queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/examples/nf-queue.c b/examples/nf-queue.c
> index 3da2c24..7d34081 100644
> --- a/examples/nf-queue.c
> +++ b/examples/nf-queue.c
> @@ -15,7 +15,7 @@
>
>  #include <libnetfilter_queue/libnetfilter_queue.h>
>
> -/* only for NFQA_CT, not needed otherwise: */
> +/* only for CTA_MARK, not needed otherwise: */

The reference to NFQA_CT is correct.

enum nfqnl_attr_type {
        NFQA_UNSPEC,
        NFQA_PACKET_HDR,
        NFQA_VERDICT_HDR,               /* nfqnl_msg_verdict_hrd */
        NFQA_MARK,                      /* __u32 nfmark */
        NFQA_TIMESTAMP,                 /* nfqnl_msg_packet_timestamp */
        NFQA_IFINDEX_INDEV,             /* __u32 ifindex */
        NFQA_IFINDEX_OUTDEV,            /* __u32 ifindex */
        NFQA_IFINDEX_PHYSINDEV,         /* __u32 ifindex */
        NFQA_IFINDEX_PHYSOUTDEV,        /* __u32 ifindex */
        NFQA_HWADDR,                    /* nfqnl_msg_packet_hw */
        NFQA_PAYLOAD,                   /* opaque data payload */
        NFQA_CT,                        /* nf_conntrack_netlink.h */

NFQA_CT the attribute nest that contains the CTA_* attributes that
represent the conntrack object, ie.

        NFQA_CT
          CTA_...
          CTA_...
          CTA_...

Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2541C39F3B6
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 12:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFHKkd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 06:40:33 -0400
Received: from mail.netfilter.org ([217.70.188.207]:56208 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhFHKkd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:40:33 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id F2BAB63E3D;
        Tue,  8 Jun 2021 12:37:27 +0200 (CEST)
Date:   Tue, 8 Jun 2021 12:38:37 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf-next PATCH v2] netfilter: nft_exthdr: Fix for unsafe packet
 data read
Message-ID: <20210608103837.GB16424@salvia>
References: <20210608094057.24598-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608094057.24598-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 08, 2021 at 11:40:57AM +0200, Phil Sutter wrote:
> While iterating through an SCTP packet's chunks, skb_header_pointer() is
> called for the minimum expected chunk header size. If (that part of) the
> skbuff is non-linear, the following memcpy() may read data past
> temporary buffer '_sch'. Use skb_copy_bits() instead which does the
> right thing in this situation.

Applied, thanks.

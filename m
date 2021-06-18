Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536463ACB0C
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Jun 2021 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFRMgU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Jun 2021 08:36:20 -0400
Received: from mail.netfilter.org ([217.70.188.207]:50236 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhFRMgU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:36:20 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 745D56425E;
        Fri, 18 Jun 2021 14:32:49 +0200 (CEST)
Date:   Fri, 18 Jun 2021 14:34:07 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf-next PATCH v2] netfilter: nft_exthdr: Search chunks in SCTP
 packets only
Message-ID: <20210618123407.GA8464@salvia>
References: <20210611170645.11245-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210611170645.11245-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jun 11, 2021 at 07:06:45PM +0200, Phil Sutter wrote:
> Since user space does not generate a payload dependency, plain sctp
> chunk matches cause searching in non-SCTP packets, too. Avoid this
> potential mis-interpretation of packet data by checking pkt->tprot.

Applied, thanks.

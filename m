Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9347DB93
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Dec 2021 00:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245755AbhLVXwp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Dec 2021 18:52:45 -0500
Received: from mail.netfilter.org ([217.70.188.207]:41626 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhLVXwp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:52:45 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8B9EC607C4;
        Thu, 23 Dec 2021 00:50:10 +0100 (CET)
Date:   Thu, 23 Dec 2021 00:52:40 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables] nft-shared: set correc register value
Message-ID: <YcO6SNssAv2XmRRZ@salvia>
References: <20211218201415.257721-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211218201415.257721-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Dec 18, 2021 at 09:14:15PM +0100, Florian Westphal wrote:
> reg is populated based off the payload base:
> 
> NFTNL_EXPR_META_KEY     = NFTNL_EXPR_BASE,
> NFTNL_EXPR_META_DREG,
> NFTNL_EXPR_PAYLOAD_DREG = NFTNL_EXPR_BASE,
> 
> Fix this.  It worked because the simple nft rules
> currently generated via ipables-nft have
> base == register-number but this is a coincidence.

s/correc/correct/

other than that, LGTM, thanks

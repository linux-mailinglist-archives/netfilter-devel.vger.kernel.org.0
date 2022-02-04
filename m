Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39504A931D
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Feb 2022 05:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiBDEld (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Feb 2022 23:41:33 -0500
Received: from mail.netfilter.org ([217.70.188.207]:49006 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiBDEld (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Feb 2022 23:41:33 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id A8EEE60195;
        Fri,  4 Feb 2022 05:41:27 +0100 (CET)
Date:   Fri, 4 Feb 2022 05:41:29 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_payload: don't allow th access for
 fragments
Message-ID: <YfyueZomR83YEK63@salvia>
References: <20220129161323.173737-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220129161323.173737-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jan 29, 2022 at 05:13:23PM +0100, Florian Westphal wrote:
> Loads relative to ->thoff naturally expect that this points to the
> transport header, but this is only true if pkt->fragoff == 0.
> 
> This has little effect for rulesets with connection tracking/nat because
> these enable ip defra. For other rulesets this prevents false matches.

Also applied

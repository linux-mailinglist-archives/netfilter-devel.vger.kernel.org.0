Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC54A934D
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Feb 2022 06:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiBDFTy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 4 Feb 2022 00:19:54 -0500
Received: from mail.netfilter.org ([217.70.188.207]:49210 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiBDFTw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:19:52 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1258A60014;
        Fri,  4 Feb 2022 06:19:47 +0100 (CET)
Date:   Fri, 4 Feb 2022 06:19:49 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nft_compat: suppress comment match
Message-ID: <Yfy3detkZZk7ArXM@salvia>
References: <20220201164850.11918-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220201164850.11918-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:48:50PM +0100, Florian Westphal wrote:
> No need to have the datapath call the always-true comment match stub.

Applied, thanks

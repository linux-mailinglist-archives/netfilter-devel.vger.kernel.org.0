Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616D66ABDE3
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Mar 2023 12:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCFLM2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Mar 2023 06:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCFLMY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:12:24 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0B582799D
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Mar 2023 03:11:40 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:10:47 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Major =?utf-8?B?RMOhdmlk?= <major.david@balasys.hu>
Subject: Re: [PATCH nf] netfilter: tproxy: fix deadlock due to missing BH
 disable
Message-ID: <ZAXKN/qGNssc93ST@salvia>
References: <20230303095856.30402-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230303095856.30402-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 03, 2023 at 10:58:56AM +0100, Florian Westphal wrote:
> The xtables packet traverser performs an unconditional local_bh_disable(),
> but the nf_tables evaluation loop does not.
> 
> Functions that are called from either xtables or nftables must assume
> that they can be called in process context.
> 
> inet_twsk_deschedule_put() assumes that no softirq interrupt can occur.
> If tproxy is used from nf_tables its possible that we'll deadlock
> trying to aquire a lock already held in process context.
> 
> Add a small helper that takes care of this and use it.

Applied, thanks

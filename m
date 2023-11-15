Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399C17E0609
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjKCQBh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344957AbjKCQBg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:01:36 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D6111
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 09:01:32 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qywbx-0006hw-NS; Fri, 03 Nov 2023 17:01:29 +0100
Date:   Fri, 3 Nov 2023 17:01:29 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables 1/4] arptables-nft: use ARPT_INV flags
 consistently
Message-ID: <20231103160129.GD8035@breakpoint.cc>
References: <20231103102330.27578-1-fw@strlen.de>
 <20231103102330.27578-2-fw@strlen.de>
 <ZUUYMEGTRN2OFBwn@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUUYMEGTRN2OFBwn@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Hmm. This is a partial revert of 44457c0805905 ("xtables-arp: Don't use
> ARPT_INV_*") and therefore very likely incomplete - e.g. it does not
> reinstate ipt_to_arpt_flags() which was used in nft_arp_parse_meta().
> 
> Above commit introduced IPT_INV_SRCDEVADDR in the first place, iptables
> does not make use of it.
> 
> A revert of that commit requires a thorough review of later changes in
> arptables code as it may have allowed for some code-sharing which is no
> longer possible then. So please hold back with this a bit, I'll check if
> any follow-ups are required.

Well, in that case it might be better to convert libarpt_mangle.c
AND remove all of the ARTP_INV?

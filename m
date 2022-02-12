Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205A14B31A1
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Feb 2022 01:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354316AbiBLACi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Feb 2022 19:02:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbiBLACg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:02:36 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4387BD6C
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Feb 2022 16:02:33 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nIfrv-0003VH-8p; Sat, 12 Feb 2022 01:02:28 +0100
Date:   Sat, 12 Feb 2022 01:02:27 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, eric.dumazet@gmail.com,
        fw@strlen.de
Subject: Re: [PATCH nf] netfilter: xt_socket: missing ifdef
 CONFIG_IP6_NF_IPTABLES dependency
Message-ID: <20220212000227.GA6497@breakpoint.cc>
References: <20220211235609.218507-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211235609.218507-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> nf_defrag_ipv6_disable() requires CONFIG_IP6_NF_IPTABLES.

Indeed, thanks for the fix.

Acked-by: Florian Westphal <fw@strlen.de>

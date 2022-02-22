Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3FB4BF2BB
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Feb 2022 08:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiBVH3d (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Feb 2022 02:29:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiBVH3c (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:29:32 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0981897B90
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Feb 2022 23:29:07 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0671F64384;
        Tue, 22 Feb 2022 08:28:07 +0100 (CET)
Date:   Tue, 22 Feb 2022 08:29:03 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH nf] netfilter: nf_tables: make sure err is initialised to
 sane value
Message-ID: <YhSQvyHEt4gHWGSp@salvia>
References: <20220221210423.28805-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221210423.28805-1-fw@strlen.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:04:23PM +0100, Florian Westphal wrote:
> All warnings (new ones prefixed by >>):
> 
> net/netfilter/nf_tables_api.c:6561:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true

I have collapsed this to the original patch, thanks!

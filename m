Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265AB4F95F2
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Apr 2022 14:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiDHMml (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 Apr 2022 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDHMmg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:42:36 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A726C176D0F
        for <netfilter-devel@vger.kernel.org>; Fri,  8 Apr 2022 05:40:31 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 69699643A2;
        Fri,  8 Apr 2022 14:36:41 +0200 (CEST)
Date:   Fri, 8 Apr 2022 14:40:28 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf-next PATCH] netfilter: nf_log_syslog: Consolidate entry
 checks
Message-ID: <YlAtPO6K8iUmYgJ4@salvia>
References: <20220324153422.8497-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324153422.8497-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:34:22PM +0100, Phil Sutter wrote:
> Every syslog logging callback has to perform the same check to cover for
> rogue containers, introduce a helper for clarity. Drop the FIXME as
> there is a viable solution since commit 2851940ffee31 ("netfilter: allow
> logging from non-init namespaces").

Applied, thanks

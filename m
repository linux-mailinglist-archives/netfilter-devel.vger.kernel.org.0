Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA355445F
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jun 2022 10:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352018AbiFVHGn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Jun 2022 03:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbiFVHGm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:06:42 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC79136B60
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jun 2022 00:06:41 -0700 (PDT)
Date:   Wed, 22 Jun 2022 09:06:36 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
Cc:     netfilter-devel@vger.kernel.org, mikhail.sennikovsky@gmail.com
Subject: Re: [PATCH 1/3] conntrack: introduce new -A command
Message-ID: <YrK/fEXoHtspnkpi@salvia>
References: <20220621225547.69349-1-mikhail.sennikovskii@ionos.com>
 <20220621225547.69349-2-mikhail.sennikovskii@ionos.com>
 <YrK/LuvlSQVtED0a@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrK/LuvlSQVtED0a@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 22, 2022 at 09:05:22AM +0200, Pablo Neira Ayuso wrote:
> On Wed, Jun 22, 2022 at 12:55:45AM +0200, Mikhail Sennikovsky wrote:
> > The -A command works exactly the same way as -I except that it
> > does not fail if the ct entry already exists.
> > This command is useful for the batched ct loads to not abort if
> > some entries being applied exist.
> > 
> > The ct entry dump in the "save" format is now switched to use the
> > -A command as well for the generated output.
> 
> For those reading this patch: Mikhail would like to have a way to
> restore a batch of conntrack entries skipping failures in insertions
> (currently, -I sets on NLM_F_CREATE), hence this new -A command.
> The conntrack tool does not have create and add like nftables, it used
> to have -I only. The mapping here is: -I means NLM_F_CREATE and -A
> means no NLM_F_CREATE (report no error on EEXIST).

Oh, regarding my comment:

actually in conntrack there is -I/--create already.  -I was selected
to keep in aligned with iptables syntax.  So there is a create indeed
already, behind -I.

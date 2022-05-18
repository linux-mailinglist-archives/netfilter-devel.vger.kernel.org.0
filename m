Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F274F52BF90
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbiERPfd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbiERPf3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 11:35:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D87EE179C23
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 08:35:28 -0700 (PDT)
Date:   Wed, 18 May 2022 17:35:25 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fasnacht@protonmail.ch
Subject: Re: [PATCH nf] netfilter: nft_numgen: disable preempt to access
 per-cpu data
Message-ID: <YoUSPR2ZmQEDob4e@salvia>
References: <20220516085552.212616-1-pablo@netfilter.org>
 <YoT8lLOVB0mRTXpv@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoT8lLOVB0mRTXpv@salvia>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 18, 2022 at 04:03:00PM +0200, Pablo Neira Ayuso wrote:
> On Mon, May 16, 2022 at 10:55:52AM +0200, Pablo Neira Ayuso wrote:
> > [233241.951068] BUG: using smp_processor_id() in preemptible [00000000] code: nginx/2725
> > [233241.951220] caller is nft_ng_random_eval+0x24/0x54 [nft_numgen]
> > [233241.951225] CPU: 2 PID: 2725 Comm: nginx Tainted: G           OE 5.16.0-0.bpo.4-amd64 #1  Debian 5.16.12-1~bpo11+1
> > [233241.951227] Hardware name: Supermicro SYS-5039MC-H8TRF/X11SCD-F, BIOS 1.7 11/23/2021
> > [233241.951228] Call Trace:
> > [233241.951231]  <TASK>
> > [233241.951233]  dump_stack_lvl+0x48/0x5e
> > [233241.951236]  check_preemption_disabled+0xde/0xe0
> > [233241.951239]  nft_ng_random_eval+0x24/0x54 [nft_numgen]
> 
> For the record, patch applied to nf.git

I don't think my patch is correct, I should disable_bh instead.

I kept it back.

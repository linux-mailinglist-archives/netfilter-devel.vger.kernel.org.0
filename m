Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D07578582
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Jul 2022 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiGROdZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Jul 2022 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiGROc4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:32:56 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D02E21E22
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Jul 2022 07:32:55 -0700 (PDT)
Date:   Mon, 18 Jul 2022 16:32:48 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] parser_bison: bail out on too long names
Message-ID: <YtVvELuDSCMcsDhX@salvia>
References: <20220716080549.162980-1-pablo@netfilter.org>
 <YtKnbGh/FdJHlil3@orbyte.nwl.cc>
 <YtVEzsOM4VxFW4An@salvia>
 <YtVc2axPCJwADuNM@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YtVc2axPCJwADuNM@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 18, 2022 at 03:15:05PM +0200, Phil Sutter wrote:
> On Mon, Jul 18, 2022 at 01:32:30PM +0200, Pablo Neira Ayuso wrote:
> > On Sat, Jul 16, 2022 at 01:56:28PM +0200, Phil Sutter wrote:
> > > Hi,
> > > 
> > > On Sat, Jul 16, 2022 at 10:05:49AM +0200, Pablo Neira Ayuso wrote:
> > > > If user specifies a too long object name, bail out.
> > > 
> > > Shouldn't this be done in eval phase or so? As-is, this patch introduces
> > > a standard syntax-specific limitation people may circumvent using JSON,
> > > no?
> > 
> > I can do it from eval phase. I will have to add more eval functions
> > though, because eval is not always called from for every command.
> 
> All I'm saying is we shouldn't divert in between the two parsers. Why is
> limiting the max name length required, BTW?

Right, this should be handled for the json parser too, sending v2.

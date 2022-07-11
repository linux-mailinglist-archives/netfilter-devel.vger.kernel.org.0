Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51C55CB9C
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jun 2022 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiF0KTd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Jun 2022 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiF0KT0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:19:26 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 894DE2199
        for <netfilter-devel@vger.kernel.org>; Mon, 27 Jun 2022 03:19:25 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:19:22 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Peter Tirsek <peter@tirsek.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] evaluate: fix segfault when adding elements to
 invalid set
Message-ID: <YrmEKowjcFRxfhLd@salvia>
References: <8665536e-5724-ec18-60e8-685deb086649@wolfie.tirsek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8665536e-5724-ec18-60e8-685deb086649@wolfie.tirsek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jun 26, 2022 at 12:47:07AM -0500, Peter Tirsek wrote:
> Adding elements to a set or map with an invalid definition causes nft to
> segfault. The following nftables.conf triggers the crash:
> 
>     flush ruleset
>     create table inet filter
>     set inet filter foo {}
>     add element inet filter foo { foobar }
> 
> Simply parsing and checking the config will trigger it:
> 
>     $ nft -c -f nftables.conf.crash
>     Segmentation fault
> 
> The error in the set/map definition is correctly caught and queued, but
> because the set is invalid and does not contain a key type, adding to it
> causes a NULL pointer dereference of set->key within setelem_evaluate().
> 
> I don't think it's necessary to queue another error since the underlying
> problem is correctly detected and reported when parsing the definition
> of the set. Simply checking the validity of set->key before using it
> seems to fix it, causing the error in the definition of the set to be
> reported properly. The element type error isn't caught, but that seems
> reasonable since the key type is invalid or unknown anyway:
> 
>     $ ./nft -c -f ~/nftables.conf.crash
>     /home/pti/nftables.conf.crash:3:21-21: Error: set definition does not specify key
>     set inet filter foo {}
>                         ^

Applied, thanks

Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0350F58DFC7
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Aug 2022 21:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245551AbiHITHY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Aug 2022 15:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343628AbiHITFQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:05:16 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78D7827163
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Aug 2022 11:43:28 -0700 (PDT)
Date:   Tue, 9 Aug 2022 20:43:25 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Peter Collinson <pc@hillside.co.uk>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] Extends py/nftables.py
Message-ID: <YvKqza6oecXKPfS9@salvia>
References: <24382147-4BE6-48D1-845C-C8DB85253CE4@hillside.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24382147-4BE6-48D1-845C-C8DB85253CE4@hillside.co.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Peter,

On Thu, Jul 07, 2022 at 05:09:34PM +0100, Peter Collinson wrote:
> Pablo Neira Ayuso has asked me to send this patch to this list. It closes 
> https://bugzilla.netfilter.org/show_bug.cgi?id=1591.
> 
> I was not sure if the output from git format-patch should be emailed
> directly, so apologies if an attachment is not what is expected.

Could you use git send-email to send you patch? Otherwise it does not
show up in patchwork (more easily gets lost):

https://patchwork.ozlabs.org/project/netfilter-devel/list/

Another nit: please add two line breaks after the title, so you patch
description looks like:

 py: add full mapping to the libnftables API

 Allows py/nftables.py to support full mapping to the libnftables API.
 The changes allow python code to talk in text to the kernel rather
 than just using json. The Python API can now also use dryruns to test
 changes

Thanks.

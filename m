Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF01B616B7B
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Nov 2022 19:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKBSEr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Nov 2022 14:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKBSEr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:04:47 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 503C7101DB;
        Wed,  2 Nov 2022 11:04:44 -0700 (PDT)
Date:   Wed, 2 Nov 2022 19:04:36 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org,
        netfilter-announce@lists.netfilter.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] ulogd 2.0.8 release
Message-ID: <Y2KxNLwxbo2zN28J@salvia>
References: <Y2JE0PygwmrhC6Q1@salvia>
 <65o51noo-oo7n-5325-p7q-5734s0pr24os@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65o51noo-oo7n-5325-p7q-5734s0pr24os@vanv.qr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:51:34PM +0100, Jan Engelhardt wrote:
> 
> On Wednesday 2022-11-02 11:22, Pablo Neira Ayuso wrote:
> >
> >You can download it from:
> >
> >https://www.netfilter.org/projects/ulogd/downloads.html
> 
> The git repo is still missing the 2.0.8 tag.

Just pushed out the commit and tag, sorry.

> Is it also possible to have git-over-https?

I'll try to take a look before end of year, but no promises.

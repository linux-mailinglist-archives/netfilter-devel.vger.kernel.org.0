Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD98583A18
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Jul 2022 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiG1INP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Jul 2022 04:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiG1INN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:13:13 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED6361D9D
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Jul 2022 01:13:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oGydj-0001vP-Im; Thu, 28 Jul 2022 10:13:03 +0200
Date:   Thu, 28 Jul 2022 10:13:03 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     netfilter-devel@vger.kernel.org, rkolchmeyer@google.com,
        pablo@netfilter.org
Subject: Re: [PATCH resend] ebtables: extend the 'static' build target fix.
Message-ID: <YuJFD5/1y1rhhyCZ@strlen.de>
References: <20220625081441.13323-1-justin.swartz@risingedge.co.za>
 <42ed3ff1408e811918f138e1f1aefec1@risingedge.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ed3ff1408e811918f138e1f1aefec1@risingedge.co.za>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Justin Swartz <justin.swartz@risingedge.co.za> wrote:
> Assign "-all-static" (instead of "-static") to "static_LDFLAGS" in
> Makefile.am, as libtool will only produce a static binary if it is
> explicitly told that all of the linked libraries should be static.

Before libtool conversion "make static" did not create a static binary
either.  It builds a version of ebtables that has libebtables.so 
baked in.

So, as far as I can see, "make static" does the same thing it
did prio to automake/libtool conversion, place all the extensions
and libebtables in the "static" binary, but link libc.so dynamically.


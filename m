Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9C7D9DBB
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Oct 2023 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjJ0QCF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Oct 2023 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjJ0QCE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:02:04 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E710A
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Oct 2023 09:01:59 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qwPHZ-0002of-Rv; Fri, 27 Oct 2023 18:01:57 +0200
Date:   Fri, 27 Oct 2023 18:01:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 07/10] man: grammar fixes to some manpages
Message-ID: <ZTve9barwc6fP1fk@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jan Engelhardt <jengelh@inai.de>, netfilter-devel@vger.kernel.org
References: <20231026085506.94343-1-jengelh@inai.de>
 <20231026085506.94343-7-jengelh@inai.de>
 <ZTphOV/bYuotL2l0@orbyte.nwl.cc>
 <nn5s78o8-170p-rn49-97np-4082so7q1s20@vanv.qr>
 <ZTuaqMniOXYLI23N@orbyte.nwl.cc>
 <pp85n2q8-rs4s-q7q6-s378-3q1r986p62p1@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pp85n2q8-rs4s-q7q6-s378-3q1r986p62p1@vanv.qr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:08:20PM +0200, Jan Engelhardt wrote:
> On Friday 2023-10-27 13:10, Phil Sutter wrote:
> >> >
> >> >"default SNAT source port selection heuristics"? I lean towards putting
> >> >dashes everywhere, but my language spoils me. ;)
> >> 
> >> Third time's the charm, hopefully?
> >
> >Did you intentionally revert from '\[-]' back to '\-' in math formulae?
> 
> Yes I gave my reasoning in
>  Message-ID: <n5qnp222-6p4s-r2p4-p6oq-0s1n4qq5496n@vanv.qr>

You were a bit vague in there, I couldn't quite tell whether you were to
change them or not.

> \[-] is GNU-specific syntax.

OK, fine. Meanwhile pushed your patches, thanks!

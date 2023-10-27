Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9D7D9957
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Oct 2023 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjJ0NI1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Oct 2023 09:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0NI0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:08:26 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E84C2
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Oct 2023 06:08:23 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 8BDA25872D3A1; Fri, 27 Oct 2023 15:08:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 8AC1F60C4DFAF;
        Fri, 27 Oct 2023 15:08:20 +0200 (CEST)
Date:   Fri, 27 Oct 2023 15:08:20 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Phil Sutter <phil@nwl.cc>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 07/10] man: grammar fixes to some manpages
In-Reply-To: <ZTuaqMniOXYLI23N@orbyte.nwl.cc>
Message-ID: <pp85n2q8-rs4s-q7q6-s378-3q1r986p62p1@vanv.qr>
References: <20231026085506.94343-1-jengelh@inai.de> <20231026085506.94343-7-jengelh@inai.de> <ZTphOV/bYuotL2l0@orbyte.nwl.cc> <nn5s78o8-170p-rn49-97np-4082so7q1s20@vanv.qr> <ZTuaqMniOXYLI23N@orbyte.nwl.cc>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Friday 2023-10-27 13:10, Phil Sutter wrote:
>> >
>> >"default SNAT source port selection heuristics"? I lean towards putting
>> >dashes everywhere, but my language spoils me. ;)
>> 
>> Third time's the charm, hopefully?
>
>Did you intentionally revert from '\[-]' back to '\-' in math formulae?

Yes I gave my reasoning in
 Message-ID: <n5qnp222-6p4s-r2p4-p6oq-0s1n4qq5496n@vanv.qr>

\[-] is GNU-specific syntax.

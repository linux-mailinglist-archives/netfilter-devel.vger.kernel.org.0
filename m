Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3576CBCE
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Aug 2023 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjHBLb5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Aug 2023 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjHBLb5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:31:57 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EE7211B
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Aug 2023 04:31:55 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 844355872FA7E; Wed,  2 Aug 2023 13:31:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 8258160C29143;
        Wed,  2 Aug 2023 13:31:53 +0200 (CEST)
Date:   Wed, 2 Aug 2023 13:31:53 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Phil Sutter <phil@nwl.cc>
cc:     netfilter-devel@vger.kernel.org, debian@helgefjell.de
Subject: Re: [iptables PATCH 06/16] man: iptables.8: Trivial font fixes
In-Reply-To: <ZMouXeTcmQOZ17QQ@orbyte.nwl.cc>
Message-ID: <p51ropqs-5so5-s52p-7po4-q7808oq04q58@vanv.qr>
References: <20230802020400.28220-1-phil@nwl.cc> <20230802020400.28220-7-phil@nwl.cc> <7n662o78-97qr-25n8-130s-prp6rp35n1r0@vanv.qr> <ZMouXeTcmQOZ17QQ@orbyte.nwl.cc>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2023-08-02 12:22, Phil Sutter wrote:
>
>> (Also note that ifff you did \fBiptables-save\fP, it would have need to be
>> \fBiptables\-save\fP, because that is required for verbatim forms.)
>
>Ah, thanks! It's misleading if output looks fine anyway.

You just need a better font! '-' U+002D in troff source becomes U+2010 in
rendering. (At least on some systems. Mine is currently suffering from demo
effect. ;-)

That's why \- is used.

>> > .TP
>> > \fB\-4\fP, \fB\-\-ipv4\fP
>> >-This option has no effect in iptables and iptables-restore.
>> >+This option has no effect in \fBiptables\fP and \fBiptables-restore\fP.
>> > If a rule using the \fB\-4\fP option is inserted with (and only with)
>> >-ip6tables-restore, it will be silently ignored. Any other uses will throw an
>> >+\fBip6tables-restore\fP, it will be silently ignored. Any other uses will throw an
>
>Can you maybe clarify how to distinct between "command" and "name"? I'm
>tempted to just leave things as they are instead of doing changes
>randomly.

Tough question, I like it.

1.
For example, the command is `fontforge`, but the program's name is FontForge.
When a name is the same as a command, it gets trickier.

2.
A name can be substituted by "the program"/"program X", without a sentence
losing its meaning; a command can be prefixed by "the command" without breaking
the sentence.

	< ls consists of 6000 LOC
	>
	  O  The program consists of 6000 LOC
	  X  The command `ls` consists of 6000 LOC  [nope - it's usually 1!]

Arguably, one can create sentences where both become valid, and the -4 option
thing quoted above seems to be one such thing.

Oh well.

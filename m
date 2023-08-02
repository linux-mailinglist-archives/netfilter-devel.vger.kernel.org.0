Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B488576C87C
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Aug 2023 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjHBImA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Aug 2023 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjHBImA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:42:00 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EF5B2
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Aug 2023 01:41:59 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id D82345872FA7D; Wed,  2 Aug 2023 10:41:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id D649C60C29143;
        Wed,  2 Aug 2023 10:41:57 +0200 (CEST)
Date:   Wed, 2 Aug 2023 10:41:57 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Phil Sutter <phil@nwl.cc>
cc:     netfilter-devel@vger.kernel.org, debian@helgefjell.de
Subject: Re: [iptables PATCH 14/16] man: iptables-save.8: Fix --modprobe
 description
In-Reply-To: <20230802020400.28220-15-phil@nwl.cc>
Message-ID: <01q40404-9642-2s23-61n6-21747n604196@vanv.qr>
References: <20230802020400.28220-1-phil@nwl.cc> <20230802020400.28220-15-phil@nwl.cc>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2023-08-02 04:03, Phil Sutter wrote:
>--- a/iptables/iptables-save.8.in
>+++ b/iptables/iptables-save.8.in
>@@ -36,9 +36,10 @@ and
> are used to dump the contents of IP or IPv6 Table in easily parseable format
> either to STDOUT or to a specified file.
> .TP
>-\fB\-M\fR, \fB\-\-modprobe\fR \fImodprobe_program\fP
>-Specify the path to the modprobe program. By default, iptables-save will
>-inspect /proc/sys/kernel/modprobe to determine the executable's path.
>+\fB\-M\fR, \fB\-\-modprobe\fR \fImodprobe\fP
>+Specify the path to the \fBmodprobe\fP(8) program. By default,
>+\fBiptables-save\fP will inspect \fI/proc/sys/kernel/modprobe\fP to determine
>+the executable's path.

Cf. 6/16.

Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738366A518
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Jan 2023 22:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjAMVYn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Jan 2023 16:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbjAMVYl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:24:41 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E520857CA
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Jan 2023 13:24:37 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id E2CDC587E7E25; Fri, 13 Jan 2023 22:24:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id DE6A660DA48D9;
        Fri, 13 Jan 2023 22:24:34 +0100 (CET)
Date:   Fri, 13 Jan 2023 22:24:34 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Phil Sutter <phil@nwl.cc>
cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Arturo Borrero Gonzalez <arturo@netfilter.org>
Subject: Re: [PATCH] build: put xtables.conf in EXTRA_DIST
In-Reply-To: <Y8FE0vEvtZhY6LCv@orbyte.nwl.cc>
Message-ID: <sp7855rr-r13r-p4r-p433-qr293769q22n@vanv.qr>
References: <20230112225517.31560-1-jengelh@inai.de> <Y8FE0vEvtZhY6LCv@orbyte.nwl.cc>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Friday 2023-01-13 12:47, Phil Sutter wrote:

>Hi Jan,
>
>On Thu, Jan 12, 2023 at 11:55:17PM +0100, Jan Engelhardt wrote:
>> To make distcheck succeed, disting it is enough; it does not need
>> to be installed.
>
>Instead of preventing it from being installed, how about dropping it
>altogether?

Sure.

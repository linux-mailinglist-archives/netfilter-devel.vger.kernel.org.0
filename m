Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5B529C13
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 May 2022 10:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbiEQIRI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 May 2022 04:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbiEQIQp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 May 2022 04:16:45 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7554B1EB
        for <netfilter-devel@vger.kernel.org>; Tue, 17 May 2022 01:14:11 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 33C2A58909C82; Tue, 17 May 2022 10:14:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 32C6060C1E82D;
        Tue, 17 May 2022 10:14:10 +0200 (CEST)
Date:   Tue, 17 May 2022 10:14:10 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Phil Sutter <phil@nwl.cc>
cc:     vincent@systemli.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] treewide: use uint* instead of u_int*
In-Reply-To: <YoNYjq2yDr3jbnyv@orbyte.nwl.cc>
Message-ID: <r4s26683-61sq-8p27-o94-92rr8sqo796@vanv.qr>
References: <9n33705n-4s4r-q4s1-q97-76n73p18s99r@vanv.qr> <20220516161641.15321-1-vincent@systemli.org> <YoNYjq2yDr3jbnyv@orbyte.nwl.cc>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Tuesday 2022-05-17 10:10, Phil Sutter wrote:
>> +++ b/include/libipq/libipq.h

>> -	u_int8_t blocking;
>> +	uint8_t blocking;
>
>Might this break API compatibility? ABI won't change, but I suppose
>users would have to include stdint.h prior to this header. Are we safe
>if we change the include from sys/types.h to stdint.h in line 27 of that
>file?

Always include what you use, so yeah, libipq.h should include stdint.h.


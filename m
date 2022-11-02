Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9B61620C
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Nov 2022 12:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiKBLvi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Nov 2022 07:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKBLvh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:51:37 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071E28714;
        Wed,  2 Nov 2022 04:51:36 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id AEE5C58726423; Wed,  2 Nov 2022 12:51:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id AC8E060C28F4A;
        Wed,  2 Nov 2022 12:51:34 +0100 (CET)
Date:   Wed, 2 Nov 2022 12:51:34 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
cc:     netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org,
        netfilter-announce@lists.netfilter.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] ulogd 2.0.8 release
In-Reply-To: <Y2JE0PygwmrhC6Q1@salvia>
Message-ID: <65o51noo-oo7n-5325-p7q-5734s0pr24os@vanv.qr>
References: <Y2JE0PygwmrhC6Q1@salvia>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2022-11-02 11:22, Pablo Neira Ayuso wrote:
>
>You can download it from:
>
>https://www.netfilter.org/projects/ulogd/downloads.html

The git repo is still missing the 2.0.8 tag.
Is it also possible to have git-over-https?

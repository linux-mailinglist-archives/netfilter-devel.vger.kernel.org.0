Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587DD50FE1F
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Apr 2022 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349623AbiDZNBZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Apr 2022 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350326AbiDZNBP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:15 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6616525588
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Apr 2022 05:58:05 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:58:01 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/1] configure: add an option to compile the examples
Message-ID: <YmfsWQ++9p5PdeGp@salvia>
References: <20220425160513.5343-1-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425160513.5343-1-dariobin@libero.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 25, 2022 at 06:05:13PM +0200, Dario Binacchi wrote:
> Using a configure option to compile the examples is a more common
> practice. This can also increase library usage (e.g. buildroot would
> now be able to install such applications on the created rootfs).

From context, I assume this is for libmnl.

If you run `make' it does not compile the examples.

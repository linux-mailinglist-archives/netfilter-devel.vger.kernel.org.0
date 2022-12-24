Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABB5655ACF
	for <lists+netfilter-devel@lfdr.de>; Sat, 24 Dec 2022 18:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiLXRRF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 24 Dec 2022 12:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXRRD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 24 Dec 2022 12:17:03 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 242C99FDB
        for <netfilter-devel@vger.kernel.org>; Sat, 24 Dec 2022 09:16:59 -0800 (PST)
Date:   Sat, 24 Dec 2022 18:16:55 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libmnl] doc: fix some non-native English usages
Message-ID: <Y6c0B55Iw3mqO2k/@salvia>
References: <20221223215621.2940577-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221223215621.2940577-1-jeremy@azazel.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 23, 2022 at 09:56:21PM +0000, Jeremy Sowden wrote:
> "allows to" -> "allows ${pronoun} to".  We use "you" if that appears in context,
> "one" otherwise.

$ patch -p1 < libmnl-doc-fix-some-non-native-English-usages.patch
patching file src/attr.c
Hunk #1 FAILED at 115.
Hunk #2 FAILED at 222.
Hunk #3 succeeded at 262 (offset 18 lines).
Hunk #4 succeeded at 289 (offset 18 lines).
2 out of 4 hunks FAILED -- saving rejects to file src/attr.c.rej
patching file src/nlmsg.c
Hunk #1 succeeded at 518 (offset 30 lines).
patching file src/socket.c

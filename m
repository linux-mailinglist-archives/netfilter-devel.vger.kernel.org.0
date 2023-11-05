Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2347E15DE
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 Nov 2023 19:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjKESf2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 Nov 2023 13:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKESf2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:35:28 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DC0BE
        for <netfilter-devel@vger.kernel.org>; Sun,  5 Nov 2023 10:35:25 -0800 (PST)
Received: from [78.30.35.151] (port=33184 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qzhxx-00Aa4I-QY; Sun, 05 Nov 2023 19:35:24 +0100
Date:   Sun, 5 Nov 2023 19:35:20 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Thomas Haller <thaller@redhat.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tests: shell: Fix sets/reset_command_0 for current
 kernels
Message-ID: <ZUfgaM+ywKs0fBQ1@calendula>
References: <20231102150342.3543-1-phil@nwl.cc>
 <08a7ddd943c17548bbe4a72d6c0aae3110b0d39e.camel@redhat.com>
 <ZUPXGnrqVajvEryb@orbyte.nwl.cc>
 <ZUQHXkoa+Nr6byb/@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUQHXkoa+Nr6byb/@calendula>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

For the record, patch is in -stable 6.5 since 6.5.9:

https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.5.9

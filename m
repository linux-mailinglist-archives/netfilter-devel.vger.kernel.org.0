Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A496783C2A
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Aug 2023 10:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjHVIy4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Aug 2023 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjHVIy4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:54:56 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7AE4F
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Aug 2023 01:54:30 -0700 (PDT)
Received: from [78.30.34.192] (port=41976 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qYN9e-00HGOC-FG; Tue, 22 Aug 2023 10:54:29 +0200
Date:   Tue, 22 Aug 2023 10:54:25 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [nft PATCH 1/2] meta: don't assume time_t is 64 bit in
 date_type_print()
Message-ID: <ZOR3wWw1eWLLM8Tw@calendula>
References: <20230822081318.1370371-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822081318.1370371-1-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:13:09AM +0200, Thomas Haller wrote:
> time_t on 32bit arch is not uint64_t. Even if it always were, it would
> be ugly to make such an assumption (without a static assert). Copy the
> value to a time_t variable first.

Applied, thanks.

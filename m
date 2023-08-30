Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9970678DB54
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Aug 2023 20:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbjH3Siz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245647AbjH3PrO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:47:14 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559A8122
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Aug 2023 08:47:12 -0700 (PDT)
Received: from [78.30.34.192] (port=40836 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qbNPQ-002QQq-1N; Wed, 30 Aug 2023 17:47:10 +0200
Date:   Wed, 30 Aug 2023 17:47:07 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, linux-audit@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [nf PATCH 2/2] netfilter: nf_tables: Audit log rule reset
Message-ID: <ZO9ke6vqGPz3OGY1@calendula>
References: <20230829175158.20202-1-phil@nwl.cc>
 <20230829175158.20202-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829175158.20202-2-phil@nwl.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:51:58PM +0200, Phil Sutter wrote:
> Resetting rules' stateful data happens outside of the transaction logic,
> so 'get' and 'dump' handlers have to emit audit log entries themselves.

Also applied to nf, thanks

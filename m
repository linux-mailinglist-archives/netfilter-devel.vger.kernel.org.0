Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92457C4C8D
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Oct 2023 10:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJKIBY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Oct 2023 04:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjJKIBY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:01:24 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C329B
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Oct 2023 01:01:21 -0700 (PDT)
Received: from [78.30.34.192] (port=58738 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qqU9c-00AJlc-JE; Wed, 11 Oct 2023 10:01:18 +0200
Date:   Wed, 11 Oct 2023 10:01:15 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@debian.org>
Cc:     Jeremy Sowden <jeremy@azazel.net>, netfilter-devel@vger.kernel.org,
        fw@strlen.de, phil@nwl.cc
Subject: Re: [RFC] nftables 1.0.6 -stable backports
Message-ID: <ZSZWS7StJ9nSP6cK@calendula>
References: <ZSPZiekbEmjDfIF2@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSPZiekbEmjDfIF2@calendula>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

For the record, I have pushed out this 1.0.6.y branch:

http://git.netfilter.org/nftables/log/?h=1.0.6.y

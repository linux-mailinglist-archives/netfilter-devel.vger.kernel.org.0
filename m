Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5356255CAC1
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jun 2022 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiF0Kbp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Jun 2022 06:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiF0Kbo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:31:44 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C85F86261
        for <netfilter-devel@vger.kernel.org>; Mon, 27 Jun 2022 03:31:43 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:31:40 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 1/3] parser_bison: fix error location for set elements
Message-ID: <YrmHDFXKj8bGvBdL@salvia>
References: <20220518180435.298462-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518180435.298462-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 18, 2022 at 08:04:33PM +0200, Pablo Neira Ayuso wrote:
> opt_newline causes interfere since it points to the previous line.
> Refer to set element key for error reporting.

For the record, pushed out this series with minor comestic updates.

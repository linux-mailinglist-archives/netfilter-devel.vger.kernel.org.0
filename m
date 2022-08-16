Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68415964DB
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Aug 2022 23:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiHPVor (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Aug 2022 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiHPVoq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:44:46 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7766E6524B
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Aug 2022 14:44:45 -0700 (PDT)
Date:   Tue, 16 Aug 2022 23:44:39 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Duncan Roe <duncan_roe@optusnet.com.au>,
        Duncan Roe <duncan.roe2@gmail.com>
Subject: Re: [PATCH libmnl v3 1/2] libmnl: update attribute function comments
 to use \return
Message-ID: <YvwPx4u0R5vQJSK0@salvia>
References: <20220808175020.2983706-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220808175020.2983706-1-jacob.e.keller@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:50:19AM -0700, Jacob Keller wrote:
> Update the function comments in lib/attr.c to use the \return notation,
> which produces better man page output.

For the record, patch 1/2 was already applied here:

http://git.netfilter.org/libmnl/commit/?id=a92ea99316682de75b0cbbbc0c753c7534212853

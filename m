Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA03628800
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Nov 2022 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiKNSNN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbiKNSNC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:02 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C58424BD3
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Nov 2022 10:13:01 -0800 (PST)
Date:   Mon, 14 Nov 2022 19:12:58 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Robert O'Brien <robrien@foxtrot-research.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: PATCH ulogd2 filter BASE ARP packet IP addresses
Message-ID: <Y3KFKuhzFWbbAKWL@salvia>
References: <004301d8f531$bb2c60c0$31852240$@foxtrot-research.com>
 <005601d8f532$49cd7080$dd685180$@foxtrot-research.com>
 <Y24taNAVtz53JPDB@salvia>
 <001c01d8f851$38ac6050$aa0520f0$@foxtrot-research.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001c01d8f851$38ac6050$aa0520f0$@foxtrot-research.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:47:52PM -0500, Robert O'Brien wrote:
> I will create a bug report and attach an example ulogd configuration
> file that demonstrates the issue.

OK.

> I will send a patch using git send-email and mention it in my bug
> report. What is the email address to where I should send the patch?

Please use netfilter-devel@vger.kernel.org so patchwork catches this
patch.

Thanks.

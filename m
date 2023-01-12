Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF36668C8
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Jan 2023 03:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjALCUc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Jan 2023 21:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjALCUa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:20:30 -0500
Received: from mail.sysmocom.de (mail.sysmocom.de [176.9.212.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1DCFCE9
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Jan 2023 18:20:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.sysmocom.de (Postfix) with ESMTP id 882FE1980AFC;
        Thu, 12 Jan 2023 02:20:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([127.0.0.1])
        by localhost (mail.sysmocom.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SQRIbRJbenXg; Thu, 12 Jan 2023 02:20:26 +0000 (UTC)
Received: from my.box (i59F7ADC2.versanet.de [89.247.173.194])
        by mail.sysmocom.de (Postfix) with ESMTPSA id 3D836198011C;
        Thu, 12 Jan 2023 02:20:26 +0000 (UTC)
Date:   Thu, 12 Jan 2023 03:20:25 +0100
From:   Neels Hofmeyr <nhofmeyr@sysmocom.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: build failure since commit 'xt: Rewrite unsupported compat
 expression dumping'
Message-ID: <Y79uac8cN6W8i0LF@my.box>
References: <Y738EXSaHcvYLnoH@my.box>
 <Y759ZZioewP6Ohmf@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y759ZZioewP6Ohmf@salvia>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I took a closer look: dropped the build dir and did 'git clean -dxf' -- after
that indeed the build works! Possibly there is a missing dependency in the
makefiles. I suppose I should have tried that before writing the mail, sorry...

~N

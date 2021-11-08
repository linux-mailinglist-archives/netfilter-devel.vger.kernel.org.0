Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655A2447E7B
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Nov 2021 12:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhKHLMc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Nov 2021 06:12:32 -0500
Received: from mail.netfilter.org ([217.70.188.207]:47072 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbhKHLMb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:12:31 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id CC9526063C;
        Mon,  8 Nov 2021 12:07:47 +0100 (CET)
Date:   Mon, 8 Nov 2021 12:09:41 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [ulogd2 PATCH v2 00/13] Build Improvements
Message-ID: <YYkFdfmq4gtY7Fr6@salvia>
References: <20211106161759.128364-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211106161759.128364-1-jeremy@azazel.net>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 06, 2021 at 04:17:47PM +0000, Jeremy Sowden wrote:
> Some tidying and autotools updates and fixes.

Same thing, please add a description.

Sorry for dumping this series for this "silly reason", I think this
helps dig out in the future if the natural language description
(expressed in the commit description) matches with update as a way to
spot for bugs.

It does not need to be long, I understand some little update are quite
obvious to the reader, so a concise description should be fine.

Thanks

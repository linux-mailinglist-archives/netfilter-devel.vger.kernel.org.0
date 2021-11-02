Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB90B442D06
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Nov 2021 12:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhKBLq6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Nov 2021 07:46:58 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60372 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhKBLq5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:46:57 -0400
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 81B3063F5C;
        Tue,  2 Nov 2021 12:42:28 +0100 (CET)
Date:   Tue, 2 Nov 2021 12:44:17 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [nft PATCH v2 0/3] parser: refactor and extend limit rate rules
Message-ID: <YYEkka0RD6qjI4Yq@salvia>
References: <20211029204009.954315-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211029204009.954315-1-jeremy@azazel.net>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 29, 2021 at 09:40:06PM +0100, Jeremy Sowden wrote:
> The first two patches introduce new rules to deduplicate the code for
> parsing `limit rate` expressions and make it easier to extend the
> syntax.
> 
> The third patch extends the syntax to handle expressions like `limit
> rate 1 mbytes / second`, which are not currently supported.

Series applied, thanks.

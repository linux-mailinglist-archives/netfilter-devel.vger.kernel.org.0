Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA6253B4BB
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jun 2022 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiFBIEB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Jun 2022 04:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiFBIEB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:04:01 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 461FC1117
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Jun 2022 01:04:00 -0700 (PDT)
Date:   Thu, 2 Jun 2022 10:03:57 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: rebasing libnftnl git
Message-ID: <Yphu7Utp6lyMMchd@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I'm going to move the following commits to a branch:

a5e9122b6908 expr: fib: missing #include <assert.h>
7576202723d1 expr: extend support for dynamic register allocation
e549f5b3239c include: missing libnftnl/regs.h
484ad4421a2e regs: do not assume 16 registers
b9e00458b9f3 src: add dynamic register allocation infrastructure

they refer to work in progress which I quickly pushed out which might
interfer with the next release.

new git HEAD will be the already existing commit:

        e2514c0eff4d (master) exthdr: tcp option reset support

Sorry for the inconvenience.

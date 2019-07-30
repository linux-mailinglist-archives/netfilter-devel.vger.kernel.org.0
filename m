Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345157AB2A
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jul 2019 16:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfG3Ois (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Jul 2019 10:38:48 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42928 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbfG3Ois (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:38:48 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hsTH5-0004WW-Af; Tue, 30 Jul 2019 16:38:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [RFC 0/2] typeof keyword, alternate patch
Date:   Tue, 30 Jul 2019 16:37:30 +0200
Message-Id: <20190730143732.2126-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Similar idea to Pablos approach, similar drawbacks.
It can be used

First patch is to make it easier to later on handle concatenations,
maps and the like -- it will retain the proper length so you can
have maps that e.g. return 'ct helper' or 'osf name' values.

Don't know yet when I can work on this again, I will comment
on Pablos patch set soon.



Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7177C3B34AF
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Jun 2021 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhFXRZp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Jun 2021 13:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFXRZo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:25:44 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67636C06175F
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Jun 2021 10:23:24 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s19so7142182ilj.1
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Jun 2021 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=JkpCA0c1WE0O+qtnOo4F98bjxgDcdAOfneSK2ssBcpR7YSDyg+YJFh58ZeqJrv5MlG
         ZP9f5oEu/Cac20jboaWMwGrmKTckemIAjkXFS0b1+6+P5aceOBWwHyApsPtfj+Yd/S65
         Igqr6QFkR15TT+jddIr8cKEvXX5o0/Sa0XoP1u3O6ulkFEYJPNHbhVBPT7ZlDxOlN8EV
         6zOXVaaRZwPhndH1JGanziuUK1LJnaZyM18ydqnpfa6wUCDCW9AUTkzeCg1R6iP70qiJ
         kDm8hD7hInE41JocZX7yhJhjDY0TBhnYgX3uXEXQWPgjrMevZ7KpgFq+g43j8r3CtNvj
         T+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=Z5tVkMADJ4VxpTag5+qLOO6QphlBB5HWC2qGwil21wjkjhHl/x2q1MFImEyetrDFLx
         bjLXEglYFv4m+3xPxZDw5dEsYahVRez33AfKTcH/MntUUeqr0Xklj49e2DEdJtmqfT+s
         qpantTpJEpwQV2x4yXkovhTmpCiIbn+yf+6H2QVvL5DQojH0yMHNQ5h0ZVuMyP0O2ops
         HN1Ir/Sz/2Y0iitDOLtSWsKq1nin3/saA5oQkpidHIRsEioJMGLG4aA4TkvX0GUTAV4J
         UUtJpOrYTkLAe35X3s7BAfDUaKzl53NVV++xx2hDC6PFJXvCRS1tNekjIvsAjQ9/tJ7M
         yNCg==
X-Gm-Message-State: AOAM530bdnaD1FCC9Bi9hTtKOBbHPI+0kmzuXlmy8lkTT7DyOy3F2niX
        yPDcnKCkuI8Mg3rMlrbXgrLbzK8ywkGvgbrJ2eM=
X-Google-Smtp-Source: ABdhPJxZ62ZI7yZSYkT2HhH/wgsJZv95Z4F/SUm9uQCEgH6mUoNSS2m9mIvt+OupMlpq0wrEeUgqQpt5aB8oJF682ac=
X-Received: by 2002:a92:d7c8:: with SMTP id g8mr4438396ilq.117.1624555403898;
 Thu, 24 Jun 2021 10:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:23:23
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:23:23 +0000
Message-ID: <CADB47+4p1fgC-_U-tuAJARm1t6ST052LuyPJY-w4MnCgf6wMrA@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,

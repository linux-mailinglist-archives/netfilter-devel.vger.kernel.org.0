Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0488246618
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Aug 2020 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgHQMND (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Aug 2020 08:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgHQMNC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:13:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F0C061389
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Aug 2020 05:13:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so3525313plj.6
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Aug 2020 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4oeN3s3sPeDFGbbbzXPpso6vBNsv55jbKHirNUtI5mk=;
        b=Ls5q6brqerZ/OzgNXGKcnq05N3X2WwZmjsZ/LTpeQkVFhcswlMGDQkiIkdUfniZ1uJ
         LaHn3PzJsQe0laZz5Tdhqag28aWEkaQ7BASZkmdlE585Oj0BDYVGKKUqWo5uve7LOxDE
         mfZbH9IXXBm49ODw6/dT9e/vAgaGIceDvLLY/tA8CBXOhwGVjFeJlW8riAwi3PfjdnJe
         0ypD1mEJz3zWaCtSrgTY3zlIBo9rMit1S0jdKsNAI5ivVpFFexPwc3WAstSxKMDqGQ9h
         +UIiw1lCkh1hTq2faEiS1BuLQhcih3Rz5dmlQVeTSNXUOxa2nc6/nEoUFX95SBJaHvuz
         vf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4oeN3s3sPeDFGbbbzXPpso6vBNsv55jbKHirNUtI5mk=;
        b=I+JMcLig20a4jU+gW4PjGyrsjGhv08+KsbdeVmO/aiW7PIAwwsAbdyIg29FQj+VS3R
         /K2HtHrWdxogjPUNMQl4sQyu2xgnm96R/glLNl3iC9BuEiBux6hU9VuQau7oTx9b/fLq
         iH+iiECc0MlR+EpbnK2m2a14ErXDO5WL12eAc7sIUUwzyQqP+VpeYn+2fr6JL/1dq9f4
         C3J+HluLdVmViXiS7C6yeHkS+ABwS35GVRj9Uu34Wg6FpYUAMigle5tj9QQO8VAcbZWh
         zgi5QEvK8ExIIQ7py+Vq+amsIN7NilQtEAVGnZgNC3Id7XYnems1Z07+eZFlnmdNpxXR
         7R6w==
X-Gm-Message-State: AOAM531SdddpjvQTyARTRwhua9YugO6/I43i9c7ec6fWB2mdhNpGCgTx
        oDLh9cuh2LIRTl9TIbEnEQIrwU1aWnMye9rEqY+LJX7hWpSWUQ==
X-Google-Smtp-Source: ABdhPJyF4LHcSkEgnaHygUJllmkYDiuBUjFEDCxG38iue+8w9fU8BZgxpcWn9I0hnuPxPtRyW7R95F4h1fXtipeS0Jo=
X-Received: by 2002:a17:90a:c7d1:: with SMTP id gf17mr12184846pjb.58.1597666381481;
 Mon, 17 Aug 2020 05:13:01 -0700 (PDT)
MIME-Version: 1.0
From:   Amiq Nahas <m992493@gmail.com>
Date:   Mon, 17 Aug 2020 17:42:50 +0530
Message-ID: <CAPicJaHrKqxJUV18pU+tvojjJvcV1EbvBo8VpNrgjoh0BYwz6w@mail.gmail.com>
Subject: [iptables] Use ipset with conntrack module
To:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Guys,

Currently only a single ip-address can be specified with these options
in conntrack module:
--ctorigsrc address[/mask]
--ctorigdst address[/mask]
--ctreplsrc address[/mask]
--ctrepldst address[/mask]

I would like to add a new feature into iptables so that multiple
ip-addresses can be specified at once. I am thinking this can be done
using ipset.

Please share your thoughts on how this can be implemented.

Thanks
Amiq

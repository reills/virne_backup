graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1344
  arrival_time 28424.62204597758
  lifetime 368.2167575508443
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 26
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 49
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 1
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 25
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 27
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 21
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 22
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 14
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 31
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 37
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 7
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 20
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 14
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
]

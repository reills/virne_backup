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
  id 1612
  arrival_time 36089.08656461398
  lifetime 920.8518369391929
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 48
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 36
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 41
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 32
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 50
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 25
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 27
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 43
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 46
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
]

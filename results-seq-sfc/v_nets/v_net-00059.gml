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
  id 59
  arrival_time 1222.0792830316946
  lifetime 618.1829331585784
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 48
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 44
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 27
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 27
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 37
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 19
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 44
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 39
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
]

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
  id 1849
  arrival_time 40831.00259478005
  lifetime 3269.3056588539944
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 35
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 11
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 45
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 9
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 44
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
]

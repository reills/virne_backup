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
  id 1917
  arrival_time 42084.924371471745
  lifetime 1423.693838873883
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 12
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 9
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 29
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 35
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 50
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 19
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
]
